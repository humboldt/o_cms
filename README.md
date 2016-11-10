# Outside CMS

[![Build Status](https://travis-ci.com/benjaminayres/o_cms.svg?token=SupDfrX15nFZyz6Z1cQz&branch=master)](https://travis-ci.com/benjaminayres/o_cms) [![Code Climate](https://codeclimate.com/repos/582251ca7ec35900650034b0/badges/97c43554c5b2c9a14e5b/gpa.svg)](https://codeclimate.com/repos/582251ca7ec35900650034b0/feed) [![Test Coverage](https://codeclimate.com/repos/582251ca7ec35900650034b0/badges/97c43554c5b2c9a14e5b/coverage.svg)](https://codeclimate.com/repos/582251ca7ec35900650034b0/coverage)

Open source, easy to extend content management system for Rails

### Why Outside CMS?

* Easily extend you application with Pages, Post and Image Library
* Focus on building your unique application features
* Built be easy to adapt, extend and customisable to suit any project
* Define your own authorisation around the CMS
* Designed to be easy to use for your end users
* Supports Rails 4.1.16 to 5.0
* Uses the powerful [Trix Editor](https://github.com/basecamp/trix)

------

![Outside CMS](https://s3.amazonaws.com/outside-cms/outside-demo.gif)

------

## Installation

Add Outside CMS to your gem file:
```rb
gem 'outside_cms'
```

Install the migrations:
```sh
rake db:migrate
```
(**Note**: do not run ```rake o_cms:install:migrations```. The Outside CMS's migrations live inside the gem and do not get copied into your application.)

Define a root for your application:
```rb
root to: "public#index"
```
Without this the primary navigation link 'Your Site' will error.

### Authentication

Add Outside CMS to your ```routes.rb``` and define authorised users

#### No Authentication
In development you may want to use the CMS without defining any authentication.
```rb
# config/routes.rb
mount OCms::Engine => '/o_cms'
```
By default Outside CMS is configured to use Devise and includes the user email, with edit user and sign out link in the user navigation. If you are using the CMS without devise authentication override the ``` /views/o_cms/partials/_user_navigation.html.erb ``` partial with no content to prevent errors.

#### Devise
In a production application you'll likely want to protect access to the control panel.

To allow any authenticated User
```rb
# config/routes.rb
authenticate :user do
  mount OCms::Engine => '/o_cms'
end
```
Same as above but also ensures that User.has_role? :admin returns true
```rb
# config/routes.rb
authenticate :user, lambda { |user| user.has_role? :admin } do
  mount OCms::Engine => '/o_cms'
end
```
### File Storage

Define where you would like your images to be stored by adding the below to you local initialiser e.g. ```o_cms_config.rb```

By default images are stored in the file directory, to use fog you would add.

```rb
# initilizers/o_cms_config.rb
OCms::Engine.config.file_storage = :fog``
```
## Customisation

### Navigation

You can customise the Primary and User navigation by creating these partials in your application.

* ``` /views/o_cms/partials/_primary_navigation.html.erb ```
* ``` /views/o_cms/partials/_user_navigation.html.erb ```

### Image Sizes

If you would like to define a different selection of image sizes to the default, or change the resizing and size options add the below hash to your config file. You will have to include a *Featured* option for the Post and Page featured image to work.

```rb
# initilizers/o_cms_config.rb
OCms::Engine.config.image_sizes = {
  thumb: { resize: "resize_to_fill", width: 50, height: 50 },
  medium: { resize: "resize_to_fit", width: 200, height: 200 },
  large: { resize: "resize_to_fit", width: 300, height: 300 },
  featured: { resize: "resize_to_fit", width: 400, height: 400 },
  special: { resize: "resize_to_fill", width: 600, height: 600 }
}
```

### Guidelines

Each of the pages in the site has a guidelines section, describing to your user what is expected in each form field.
You can easily override these guidelines, if you feel the language is tool simplistic or complicated for your users, or if you want to put something else in the sidebars.

* ``` /views/o_cms/pages/_guidelines.html.erb ```
* ``` /views/o_cms/images/_guidelines.html.erb ```
* ``` /views/o_cms/posts/_guidelines.html.erb ```
* ``` /views/o_cms/categories/_guidelines.html.erb ```

## Contributing

   1. Fork the project
   2. Make your changes, including tests that exercise the code
   4. Make a pull request

## License

Outside CMS is released under the MIT License.

## Author

Benjamin Ayres
