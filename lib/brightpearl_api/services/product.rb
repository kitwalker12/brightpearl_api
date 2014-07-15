module BrightpearlApi
  class Service
    module Product
      def self.included(klass)
        klass.class_eval do
          def create_brand(name, description)
            body = {
              name: name,
              description: description
            }
            call(:post, "/product-service/brand/", body)
          end

          def create_category(name, parentId = 0)
            body = {
              name: name,
              parentId: parentId
            }
            call(:post, "/product-service/brightpearl-category/", body)
          end

          def get_option_value(idset)
            id_set = parse_idset(idset)
            call(:get, "/product-service/option/#{id_set}/value")
          end

          def create_option_value(option_id, optionValueName)
            body = {
              optionValueName: optionValueName
            }
            call(:post, "/product-service/option/#{option_id.to_i}/value", body)
          end

          def update_product_price(product_id)
            body = {}
            yield(body)
            call(:put, "/product-service/product-price/#{product_id.to_i}/price-list", body)
          end

          def create_product_type(name)
            body = {
              name: name
            }
            call(:post, "/product-service/product-type/", body)
          end

          def product_type_association(product_id_set, option_id_set)
            pid = parse_idset(product_id_set)
            oid = parse_idset(option_id_set)
            call(:post, "/product-service/product-type/#{pid}/option-association/#{oid}")
          end

          def create_season(name, description)
            body = {
              name: name,
              description: description
            }
            call(:post, "/product-service/season/", body)
          end
        end
      end
    end
  end
end
