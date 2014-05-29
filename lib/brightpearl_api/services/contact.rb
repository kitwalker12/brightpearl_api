module BrightpearlApi
  class Service
    module Contact
      def self.included(klass)
        klass.class_eval do
          def associate_tag(idset, tag_id)
            id_set = parse_idset(idset)
            call(:post, "/contact-service/contact/#{id_set}/tag/#{tag_id.to_i}")
          end
        end
      end
    end
  end
end
