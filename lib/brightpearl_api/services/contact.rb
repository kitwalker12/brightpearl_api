module BrightpearlApi
  class Service
    module Contact
      def self.included(klass)
        klass.class_eval do
          def get_contact(idset)
            id_set = parse_idset(idset)
            call(:get, "/contact-service/contact/#{id_set}")
          end

          def get_contact_range_uris(idset)
            id_set = parse_idset(idset)
            call(:options, "/contact-service/contact/#{id_set}")
          end

          def get_all_contact_range_uris
            call(:options, "/contact-service/contact")
          end

          def create_contact
            body = {}
            yield(body)
            call(:post, "/contact-service/contact/", body)
          end

          def contact_search
            # TODO
          end

          def associate_tag(idset, tag_id)
            id_set = parse_idset(idset)
            call(:post, "/contact-service/contact/#{id_set}/tag/#{tag_id.to_int}")
          end

          def get_address(idset)
            id_set = parse_idset(idset)
            call(:get, "/contact-service/postal-address/#{id_set}")
          end

          def create_address
            body = {}
            yield(body)
            call(:post, "/contact-service/postal-address/", body)
          end
        end
      end
    end
  end
end
