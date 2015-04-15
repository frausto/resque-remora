module Resque
  module Plugins
    module Remora
      module PushPop
        def self.included(base)
          base.class_eval do
            alias_method :original_pop, :pop
            alias_method :original_push, :push
            extend ClassMethods
          end
        end

        module ClassMethods
          def push(queue, item)
            job_class = constantize(item[:class])
            item = job_class.remora_attachment.merge(item) if remora_class?(job_class)
            original_push queue, item
          end

          def pop(queue)
            job = original_pop(queue)
            begin
              attachment = job['remora']
              job_class = constantize(job['class'])
              if !attachment.nil? && remora_class?(job_class)
                job_class.process_remora(queue, attachment)
              end
            rescue
            end
            job
          end

          private

          def remora_class?(job_class)
            job_class && job_class.respond_to?(:process_remora) && job_class.respond_to?(:attach_remora) && job_class.respond_to?(:remora_attachment)
          end

          # From file activesupport/lib/active_support/inflector/methods.rb, line 226
          def constantize(camel_cased_word)
            names = camel_cased_word.split('::')

            # Trigger a builtin NameError exception including the ill-formed constant in the message.
            Object.const_get(camel_cased_word) if names.empty?

            # Remove the first blank element in case of '::ClassName' notation.
            names.shift if names.size > 1 && names.first.empty?

            names.inject(Object) do |constant, name|
              if constant == Object
                constant.const_get(name)
              else
                candidate = constant.const_get(name)
                next candidate if constant.const_defined?(name, false)
                next candidate unless Object.const_defined?(name)

                # Go down the ancestors to check it it's owned
                # directly before we reach Object or the end of ancestors.
                constant = constant.ancestors.inject do |const, ancestor|
                  break const    if ancestor == Object
                  break ancestor if ancestor.const_defined?(name, false)
                  const
                end

                # owner is in Object, so raise
                constant.const_get(name, false)
              end
            end
          end
        end
      end
    end
  end
end
