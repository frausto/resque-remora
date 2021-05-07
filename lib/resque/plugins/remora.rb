module Resque
  module Plugins
    module Remora
      def remora_attachment
        {:remora => attach_remora}
      end
      
      def attach_remora; {}; end
      def process_remora(_queue, _attachment); nil; end
    end
  end
end