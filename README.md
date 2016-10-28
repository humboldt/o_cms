# Outside CMS [![Build Status](https://travis-ci.com/outsidehq/o_cms.svg?token=SupDfrX15nFZyz6Z1cQz&branch=master)](https://travis-ci.com/outsidehq/o_cms)

## Customisation

### Navigation

You can customise the Primary and User navigation by creating these partials in your application.

* ``` /views/o_cms/partials/_primary_navigation.html.erb ```
* ``` /views/o_cms/partials/_user_navigation.html.erb ```

### Image sizes

You can override the default image sizes by adding the below hash to your local initializer.

```
# initilizers/o_cms_config.rb

OCms::Engine.config.image_sizes = {
  thumb: { resize: "resize_to_fill", width: 50, height: 50 },
  medium: { resize: "resize_to_fit", width: 200, height: 200 },
  large: { resize: "resize_to_fit", width: 300, height: 300 },
  featured_image: { resize: "resize_to_fit", width: 400, height: 400 },
  special_image: { resize: "resize_to_fill", width: 600, height: 600 }
}
```

### Guidelines

Each of the pages in the site has a guidelines section, describing to your user what is expected in each form field.
You can easily override these guidelines, if you feel the language is tool simplistic or complicated for your users, or if you want to put something else in the sidebars.

* ``` /views/o_cms/pages/_guidelines.html.erb ```
* ``` /views/o_cms/images/_guidelines.html.erb ```
* ``` /views/o_cms/posts/_guidelines.html.erb ```
* ``` /views/o_cms/categories/_guidelines.html.erb ```
