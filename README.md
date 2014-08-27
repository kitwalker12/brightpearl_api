# BrightpearlApi

Gem for connecting to your brightpearl account via their API

## Installation

Add this line to your application's Gemfile:

    gem 'brightpearl_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brightpearl_api

## Usage

### Initialize

Refer [Brightpearl Documentation](http://www.brightpearl.com/developer/latest/tutorial/getting-started.html) for values.

In ```config/initializers/brightpearl_api.rb```

With Environment Variables set

```(ENV['BRIGHTPEARL_EMAIL'], ENV['BRIGHTPEARL_PASSWORD'], ENV['BRIGHTPEARL_VERSION'], ENV['BRIGHTPEARL_DATACENTER'], ENV['BRIGHTPEARL_ACCOUNT'])```

```
BrightpearlApi.configure do
end
```

Else

```
BrightpearlApi.configure do |c|
  c.email = 'someone@example.com'
  c.password = 'something'
  c.version = '2.0.0'
  c.datacenter = 'ws-usw'
  c.account = 'myaccount'
end
```

Then, anywhere

```
s = BrightpearlApi::Service.new
```

### API

__All Post calls have to be passed a block which constructs a body hash__

#### Multi Purpose

*Five functions (get_resource, create_resource, update_resource, delete_resource, search_resource) take the service name and resource name as parameters. get_resource also takes an optional idset parameter which can be an int, range or array. It'll try to get all resources if idset is not provided and the API supports it.*

*Range URI's can be retrived via get_resource_range which also takes an optional range*

```
s.get_resource('product', 'product', 100)
s.get_resource('product', 'product', 100..200)
s.create_resource('contact', 'contact') do |body|
  hash = {
    salutation: "Ms.",
    firstName: "Pink",
    lastName: "Melody",
    postAddressIds: {
      DEF: 141,
      BIL: 141,
      DEL: 141
    }
  }
  body.merge!(hash)
end

s.create_resource('contact', 'postal-address') do |body|
  hash = {
    addressLine1: "Brightpearl, First Floor",
    addressLine2: "New Bond House",
    addressLine3: "Bond Street",
    addressLine4: "Bristol",
    postalCode: "BS2 9AG",
    countryIsoCode: "GBR"
  }
  body.merge!(hash)
end

s.create_resource('order', 'order') do |body|
  hash = {
    orderTypeCode: "SO",
    reference: "order#001",
    priceListId: 2,
    invoices: [
      {
        taxDate: "2012-06-08T12:57:25+00:00"
      }
    ],
    placedOn: "2011-09-29T11:12:24.000+01:00",
    orderStatus: {
      orderStatusId: 1
    },
    delivery: {
      deliveryDate: "2011-09-29T11:12:24.000+01:00",
      shippingMethodId: 2
    },
    currency: {
      orderCurrencyCode: "GBP"
    },
    parties: {
      customer: {
        contactId: 204
      }
    },
    assignment: {
      current: {
        channelId: 1,
        leadSourceId: 1,
        projectId: 1,
        staffOwnerContactId: 501,
        teamId: 2
      }
    }
  }
  body.merge!(hash)
end

s.create_resource('product', 'product') do |body|
  hash = {
    brandId: 74,
    financialDetails: {
      taxCode: {
        id: 7
      }
    },
    salesChannels: [
      {
        salesChannelName: "Brightpearl",
        productName: "Product B",
        productCondition: "new",
        categories: [
          {
            categoryCode: "276"
          }
         ]
      }
    ]
  }
  body.merge!(hash)
end

s.get_resource_range('contact', 'contact', 100..200)
s.get_resource_range('order', 'order')

s.search_resource('contact','contact') do |body|
  hash = {
    allEmail: 'me@example.com'
  }
  body.merge!(hash)
end

```

#### Supported Service - Resource Pairs

| Service      | Resource               |
| ------------ | ---------------------- |
| contact      | contact                |
| contact      | postal-address         |
| order        | order                  |
| order        | order-status           |
| product      | brand                  |
| product      | brightpearl-category   |
| product      | channel                |
| product      | option                 |
| product      | price-list             |
| product      | product                |
| product      | product-price          |
| product      | product-type           |
| product      | season                 |
| warehouse    | fulfilment-source      |
| warehouse    | product-availability   |
| warehouse    | shipping-method        |
| warehouse    | warehouse              |

#### Contact

```
s.associate_tag(idset, tag_id)
```

#### Order

```
s.order_acknowledgement(order_id, reference)
s.create_order_note(order_id)
s.get_order_row(order_id, row_id)

s.create_order_row(order_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.update_order_row(order_id, row_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.update_order_status(order_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end
```

#### Product

```
s.create_brand(name, description)
s.create_category(name, parentId)
s.get_option_value(idset)
s.create_option_value(option_id, optionValueName)

s.update_product_price(1001) do |body|
  hash = {
    priceLists: [
      {
        priceListId: 1,
        quantityPrice: {
          1: "1",
          5: "9.555",
          15: "9",
          25: "8",
          50: "7.5",
          200: "7"
        }
      },
      {
        priceListId: 2,
        quantityPrice: {
          1: "1",
          5: "9.555",
          15: "9",
          25: "8",
          50: "7.5",
          200: "7"
        }
      }
    ]
  }
  body.merge!(hash)
end

s.create_product_type(name)
s.product_type_association(product_id_set, option_id_set)
s.create_season(name, description)
```

#### Warehouse

```
s.asset_value_correction(warehouse_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.get_default_location(warehouse_id)
s.get_quarantine_location(warehouse_id)
s.get_location(warehouse_id, location_id_set)
s.delete_location(warehouse_id, location_id)

s.create_location(warehouse_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.get_drop_ship_note(sales_id_set, drop_ship_note_id_set)

s.create_drop_ship_note(sales_order_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.create_drop_ship_note_event(drop_ship_note_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.goods_in_note_correction(batch_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.create_goods_in_note(order_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.delete_goods_in_note(goods_in_note_id)
s.delete_goods_out_note(order_id, goods_out_note_id)
s.get_goods_out_note(order_id_set, goods_out_note_id_set)

s.create_goods_out_note(order_id) do |body|
  hash = {
   "warehouses: [
      {
        releaseDate: "2011-07-15T10:39:40.000+01:00",
        warehouseId: 2,
        transfer: false,
        products: [
          {
            productId: 1008,
            salesOrderRowId: 4,
            quantity: 5
          },
          {
            productId: 1007,
            salesOrderRowId: 5,
            quantity: 14
          }
        ]
      }
    ],
    priority: false,
    shippingMethodId: 4
  }
  body.merge!(hash)
end

s.update_goods_out_note(goods_out_note_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.create_goods_out_note_event(goods_out_note_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.create_internal_transfer(warehouse_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.create_external_transfer(warehouse_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end

s.quarantine_release(warehouse_id) do |body|
  hash = {
    #...
  }
  body.merge!(hash)
end
```

## TODO

Resource Search

## Contributing

1. Fork it ( http://github.com/kitwalker12/brightpearl_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
