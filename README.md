# Git informations

GitHub action used to get Terraform stack informations

## Inputs

There are no inputs for this GitHub action

## Outputs

There are no outputs for this action

## Env vars

The list o env vars generated using this GitHub action:

- **action:** Kind of git user action (modified|copied|added);
- **file:** File path in terraform stack repository;
- **env:** Environment or account name;
- **region:** The region of resource;
- **service:** Kind of service;
- **resource:** The resource name;

## Example usage

```yaml
      # Example using this actions
      - name: Get get terraform repo informations
        uses: platformbuilders/github-actions-terraform-informations@master
```

## How to send updates?
If you wants to update or make changes in module code you should use the **develop** branch of this repository, you can test your module changes passing the `@develop` in module calling. Ex.:

```yaml
      # Example using this actions
      - name: Get get terraform repo informations
        uses: platformbuilders/github-actions-terraform-informations@develop
```
After execute all tests you can open a pull request to the master branch.