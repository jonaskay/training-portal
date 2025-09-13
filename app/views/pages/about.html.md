---
title: About Us
layout: application
description: Learn more about our company and mission
---

# About Our Company

Welcome to our **training portal**! We are dedicated to providing high-quality educational content.

## Our Mission

We believe in making learning accessible to everyone. Our platform offers:

- Interactive tutorials
- Code examples
- Best practices
- Community support

## Features

### Markdown Support
This page demonstrates our new markdown view support with the following features:

- **ERB preprocessing**: Current time is <%= Time.current.strftime("%Y-%m-%d %H:%M:%S") %>
- **Front matter parsing**: Page title from front matter: <%= @front_matter&.dig('title') || 'No title' %>
- **Syntax highlighting** for code blocks:

```ruby
def hello_world
  puts "Hello, World!"
end
```

### Contact Information

For more information, please reach out to us at [contact@example.com](mailto:contact@example.com).

---

*Last updated: <%= Date.current.strftime("%B %d, %Y") %>*