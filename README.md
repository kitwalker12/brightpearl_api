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

*All Post calls have to be passed a block which constructs a body hash*

#### Contact

```
s.get_contact(200)
s.get_contact([200, 201, 207])
s.get_contact(200..205)

s.get_contact_range_uris(200..500)
s.get_all_contact_range_uris

s.get_address(151)

s.create_contact do |body|
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

s.create_address do |body|
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

s.associate_tag(201, 11)
```

#### Order

```
s.get_order(1001)
s.get_order_range_uris(1001..2001)
s.get_all_order_range_uris

s.create_order do |body|
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

s.order_acknowledgement(1001, "#1752805305.fhe908qw-z-z-plural-z-alpha")

s.create_order_note(1001) do |body|
  hash = {
    text: "Updating Order details"
  }
  body.merge!(hash)
end

s.get_order_row(10001, 1)
s.create_order_row(1001) do |body|
  hash = {
    productId: 1202,
    quantity: {
      magnitude: "12"
    },
    rowValue:{
      taxCode:"T20",
      rowNet:{
          value: "12.21"
      },
      rowTax:{
          value: "2.44"
      }
    },
    nominalCode: "4000"
  }
  body.merge!(hash)
end

s.update_order_row(1001, 2) do |body|
  hash = {
    productName: "Labour",
    quantity: {
      magnitude: "2"
    },
    rowValue:{
      taxCode:"T20",
      rowNet:{
        value: "20.00"
      },
      rowTax:{
        value: "2.44"
      }
    },
    nominalCode: "4000"
  }
  body.merge!(hash)
end

s.get_order_status(1001)
s.update_order_status do |body|
  hash = {
    orderStatusId: 21,
    orderNote: {
      text: "Updating order status!!",
      isPublic: true,
      fileId: 28
    }
  }
  body.merge!(hash)
end
```

## Contributing

1. Fork it ( http://github.com/kitwalker12/brightpearl_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
