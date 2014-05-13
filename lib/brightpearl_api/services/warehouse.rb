module BrightpearlApi
  class Service
    module Warehouse
      def self.included(klass)
        klass.class_eval do
          def asset_value_correction(warehouse_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/warehouse/#{warehouse_id.to_int}/asset-value-correction", body)
          end

          def get_default_location(warehouse_id)
            call(:get, "/warehouse-service/warehouse/#{warehouse_id.to_int}/location/default")
          end

          def get_quarantine_location(warehouse_id)
            call(:get, "/warehouse-service/warehouse/#{warehouse_id.to_int}/location/quarantine")
          end

          def get_location(warehouse_id, location_id_set = nil)
            lid = location_id_set.nil? ? "" : parse_idset(location_id_set)
            call(:get, "/warehouse-service/warehouse/#{warehouse_id.to_int}/location/#{lid}")
          end

          def create_location(warehouse_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/warehouse/#{warehouse_id.to_int}/location/", body)
          end

          def delete_location(warehouse_id, location_id)
            call(:delete, "/warehouse-service/warehouse/#{warehouse_id.to_int}/location/#{location_id.to_int}")
          end

          def get_drop_ship_note(sales_id_set, drop_ship_note_id_set = nil)
            sid = parse_idset(sales_id_set)
            did = drop_ship_note_id_set.nil? ? "" : parse_idset(drop_ship_note_id_set)
            call(:get, "/warehouse-service/order/#{sid}/goods-note/drop-ship/#{did}")
          end

          def create_drop_ship_note(sales_order_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/order/#{sales_order_id.to_int}/goods-note/drop-ship", body)
          end

          def create_drop_ship_note_event(drop_ship_note_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/goods-note/drop-ship/#{drop_ship_note_id.to_int}/event", body)
          end

          def goods_in_note_correction(batch_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/goods-note/goods-in/#{batch_id.to_int}/correction", body)
          end

          def create_goods_in_note(order_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/order/#{order_id.to_int}/goods-note/goods-in", body)
          end

          def delete_goods_in_note(goods_in_note_id)
            call(:delete, "/warehouse-service/goods-note/goods-in/#{goods_in_note_id.to_int}")
          end

          def delete_goods_out_note(order_id, goods_out_note_id)
            call(:delete, "/warehouse-service/order/#{order_id.to_int}/goods-note/goods-out/#{goods_out_note_id.to_int}")
          end

          def get_goods_out_note(order_id_set, goods_out_note_id_set = nil)
            oid = parse_idset(order_id_set)
            gid = goods_out_note_id.nil? ? "" : parse_idset(goods_out_note_id_set)
            call(:get, "/warehouse-service/order/#{oid}/goods-note/goods-out/#{gid}")
          end

          def create_goods_out_note(order_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/order/#{order_id.to_int}/goods-note/goods-out", body)
          end

          def update_goods_out_note(goods_out_note_id)
            body = {}
            yield(body)
            call(:put, "/warehouse-service/goods-note/goods-out/#{goods_out_note_id.to_int}", body)
          end

          def create_goods_out_note_event(goods_out_note_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/goods-note/goods-out/#{goods_out_note_id.to_int}/event", body)
          end

          def create_internal_transfer(warehouse_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/warehouse/#{warehouse_id.to_int}/internal-transfer", body)
          end

          def quarantine_release(warehouse_id)
            body = {}
            yield(body)
            call(:post, "/warehouse-service/warehouse/#{warehouse_id.to_int}/quarantine/release", body)
          end
        end
      end
    end
  end
end
