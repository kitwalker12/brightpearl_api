module BrightpearlApi
  class Service
    module Order
      def self.included(klass)
        klass.class_eval do
          def order_acknowledgement(order_id, reference)
            body = {
              reference: "#{reference}"
            }
            call(:put, "/order-service/order/#{order_id.to_i}/acknowledgement", body)
          end

          def create_order_note(order_id)
            body = {}
            yield(body)
            call(:post, "/order-service/order/#{order_id.to_i}/note", body)
          end

          def get_order_row(order_id, row_id)
            call(:get, "/order-service/order/#{order_id.to_i}/row/#{row_id.to_i}")
          end

          def create_order_row(order_id)
            body = {}
            yield(body)
            call(:post, "/order-service/order/#{order_id.to_i}/row", body)
          end

          def update_order_row(order_id, row_id)
            body = {}
            yield(body)
            call(:put, "/order-service/order/#{order_id.to_i}/row/#{row_id.to_i}", body)
          end

          def update_order_status(order_id)
            body = {}
            yield(body)
            call(:put, "/order-service/order/#{order_id.to_i}/status", body)
          end
          
          def update_order_custom_field(order_id)
            body = {}
            yield(body)
            call(:post, "/order-service/order/#{order_id.to_i}/custom-field", body)
          end
        end
      end
    end
  end
end
