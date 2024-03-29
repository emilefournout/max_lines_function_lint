# Feature
max_lines_function_lint allows you to display a warning when one of your functions/methods exceeds a certain number of lines

# Installing

max_lines_function_lint is implemented using [custom_lint]. As such, it uses custom_lint's installation logic.  
Long story short:
  
- Add both max_lines_function_lint and custom_lint to your `pubspec.yaml`:
  ```yaml
  dev_dependencies:
    custom_lint:
    max_lines_function_lint:
  ```
- Enable `custom_lint`'s plugin in your `analysis_options.yaml`:

  ```yaml
  analyzer:
    plugins:
      - custom_lint
  ```
  
- run with the command:

  ```sh
  dart run custom_lint
  ```

# Custom limit

Limit the maximum of line with a custom value (default 30)

```yaml
analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - max_lines_function:
      limit: 50
```

![alt text](https://github.com/emilefournout/max_lines_function_lint/blob/master/screenshots/screenshot.png)
