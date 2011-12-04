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
        end
      end
    end
  end
end