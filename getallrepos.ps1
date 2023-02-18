
# Prompt user to enter their GitHub username and personal access token
$username = Read-Host "Enter your GitHub username" 
$token = Read-Host "Enter your personal access token"

# Set the URL for the GitHub API and authenticate using the personal access token
$url = "https://api.github.com/users/$username/repos?per_page=100"
$headers = @{
    "Authorization" = "token $token" 
}

# Make a GET request to the GitHub API to retrieve the user's repositories
$response = Invoke-RestMethod -Uri $url -Headers $headers 

# Iterate through the repositories and clone the entire repository for each one to the local computer
foreach ($repo in $response) {
    $repoName = $repo.name  # The name of the repository is used to create the directory
    $cloneUrl = $repo.clone_url # The clone URL is used to clone the repository
    $sourceCodePath = $repoName # The path to the directory where the repository will be cloned
    Write-Host "Cloning repository $repoName..." # Notify user that the repository is being cloned
    git clone --depth=1 -b main $cloneUrl $sourceCodePath # If the repository does not have a main branch, use master instead
    git clone --depth=1 -b master $cloneUrl $sourceCodePath 
}

# Notify user that all repositories have been cloned
Write-Host "All repositories have been cloned to the local computer"

