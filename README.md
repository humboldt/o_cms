# Outside CMS [![Build Status](https://travis-ci.com/outsidehq/o_cms.svg?token=SupDfrX15nFZyz6Z1cQz&branch=master)](https://travis-ci.com/outsidehq/o_cms)

## Installation

### Authentication

In a production application you'll likely want to protect access to the control panel. You can use the constraints feature of routing (in the ```config/routes.rb``` file) to accomplish this:

Allow any authenticated User

```
# config/routes.rb
authenticate :user do
  mount OCms::Engine => '/o_cms'
end
```

Same as above but also ensures that User.has_role? :admin returns true

```
# config/routes.rb
authenticate :user, lambda { |user| user.has_role? :admin } do
  mount OCms::Engine => '/o_cms'
end
```

## Customisation

### Navigation

You can customise the Primary and User navigation by creating these partials in your application.

* ``` /views/o_cms/partials/_primary_navigation.html.erb ```
* ``` /views/o_cms/partials/_user_navigation.html.erb ```
