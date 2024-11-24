# AWS Amplify App Terraform Module

This Terraform module manages the deployment of an AWS Amplify App with various configurations, including repository connection, OAuth integration, and custom build and environment variables settings.

---

### **Usage**

```hcl
module "amplify_app" {
  source = "./path-to-module"

  name         = "my-amplify-app"
  repository   = "https://github.com/my-repo"
  oauth_token  = "your-oauth-token"
  access_token = "your-access-token"
  description  = "This is my Amplify app."
  platform     = "WEB"
  tags         = {
    Environment = "Production"
  }
}
```

---

### Requirements

| Name         | Version   |
| ------------ | --------- |
| Terraform    | >= 1.7.5  |
| AWS Provider | >= 5.77.0 |

---

### Providers

| Provider | Source    | Version   |
| -------- | --------- | --------- |
| `aws`    | HashiCorp | >= 5.77.0 |

---

### **Features**

- **OAuth and Access Token Integration**: Integrates with third-party Git repositories using OAuth or personal access tokens.
- **Environment Variables**: Allows defining environment variables for the app build process.
- **Branch Auto-Build and Deletion**: Configures auto-building and deletion for Git branches.
- **Custom Redirect and Rewrite Rules**: Supports custom rules for URL rewrites and redirects.
- **Platform Support**: Configurable for both web and mobile platforms.

---

### **Explanation of Files**

1. **`main.tf`**  
   Defines the `aws_amplify_app` resource and sets the attributes required to configure the app, including repository, build spec, and environment variables.

2. **`variables.tf`**  
   Declares the input variables for the module, covering all aspects of app configuration such as repository, OAuth tokens, environment variables, and more.

3. **`outputs.tf`**  
   Outputs the unique ID, ARN, and default domain of the deployed Amplify app.

4. **`README.md`**  
   Provides a guide for using the module, detailing the required and optional inputs, as well as usage examples.

---

### **Inputs**

| Name                          | Description                                                                                            | Type                                                                  | Default | Required |
| ----------------------------- | ------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------- | ------- | -------- |
| `name`                        | The name for the Amplify app.                                                                          | `string`                                                              | -       | Yes      |
| `repository`                  | The repository for the Amplify app (e.g., GitHub, GitLab).                                             | `string`                                                              | -       | Yes      |
| `oauth_token`                 | The OAuth token for a third-party source control system for the Amplify app (optional).                | `string`                                                              | `null`  | No       |
| `access_token`                | The personal access token for a third-party source control system for the Amplify app (optional).      | `string`                                                              | `null`  | No       |
| `description`                 | The description for the Amplify app (optional).                                                        | `string`                                                              | `null`  | No       |
| `enable_branch_auto_build`    | Enables auto-building of branches for the Amplify app.                                                 | `bool`                                                                | `false` | No       |
| `enable_branch_auto_deletion` | Automatically disconnects a branch in the Amplify Console when you delete a branch from your Git repo. | `bool`                                                                | `false` | No       |
| `environment_variables`       | The environment variables for the Amplify app.                                                         | `map(string)`                                                         | `{}`    | No       |
| `iam_service_role_arn`        | The AWS Identity and Access Management (IAM) service role for the Amplify app (optional).              | `string`                                                              | `null`  | No       |
| `platform`                    | The platform for the Amplify app (e.g., WEB, MOBILE).                                                  | `string`                                                              | `"WEB"` | No       |
| `build_spec`                  | The build specification (build spec) for the Amplify app (optional).                                   | `string`                                                              | `null`  | No       |
| `custom_rules`                | The custom rewrite and redirect rules for the Amplify app (optional).                                  | `list(object({ source = string, status = string, target = string }))` | `[]`    | No       |
| `tags`                        | A mapping of tags to assign to the resource (optional).                                                | `map(string)`                                                         | `{}`    | No       |

---

### **Outputs**

| Name                 | Description                             |
| -------------------- | --------------------------------------- |
| `id`                 | The unique ID of the Amplify app.       |
| `arn`                | The ARN of the Amplify app.             |
| `app_default_domain` | The default domain for the Amplify app. |

---

### **Example Usage**

#### Simple Example: Create Amplify App with GitHub Repository

```hcl
module "amplify_app" {
  source = "./path-to-module"

  name         = "my-amplify-app"
  repository   = "https://github.com/my-repo"
  oauth_token  = "your-oauth-token"
  access_token = "your-access-token"
  description  = "This is my Amplify app."
  platform     = "WEB"
  tags         = {
    Environment = "Production"
  }
}
```

#### Example with Custom Redirect Rules and Environment Variables

```hcl
module "amplify_app_with_custom_rules" {
  source = "./path-to-module"

  name         = "advanced-amplify-app"
  repository   = "https://github.com/my-advanced-repo"
  platform     = "WEB"
  custom_rules = [
    {
      source = "/old-path/*"
      status = "200"
      target = "/new-path/$1"
    }
  ]
  environment_variables = {
    APP_ENV = "production"
    API_URL = "https://api.example.com"
  }
  tags = {
    Environment = "Production"
    Owner       = "DevOps"
  }
}
```

---

### **Authors**

This module is maintained by **[David Essien](https://davidessien.com)**.

---

### **License**

This project is licensed under the MIT License. See the `LICENSE` file for details.
