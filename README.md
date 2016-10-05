# Outside CMS [![Build Status](https://travis-ci.com/outsidehq/o_cms.svg?token=SupDfrX15nFZyz6Z1cQz&branch=master)](https://travis-ci.com/outsidehq/o_cms)

## Installation

### Authentication

Define which of your users can access the CMS by following the below example.

```
  # config/routes.rb

  authenticate :user, lambda { |user| user.has_role? :admin } do
    mount OCms::Engine => "/o_cms"
  end
```

## Customisation

### Navigation

You can customise the Primary and User navigation by creating these partials in your application.

* ``` /views/o_cms/partials/_primary_navigation.html.erb ```
* ``` /views/o_cms/partials/_user_navigation.html.erb ```
