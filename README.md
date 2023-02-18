# powershell-script to clone all GitHub Account repos to local disk in case the GitHub Account is deleted.

### --depth=1 AND -b
- we use the --depth=1 option to fetch only the most recent commit of the repository, which should be sufficient to get the latest version of the source code. We also specify the -b option to checkout the master branch of the repository, which is assumed to contain the latest version of the source code.
