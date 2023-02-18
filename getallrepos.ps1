
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
    $repoName = $repo.name
    $cloneUrl = $repo.clone_url
    $sourceCodePath = $repoName # Remove "/src" from the path to clone the entire repository
    Write-Host "Cloning repository $repoName..."
    git clone --depth=1 -b main $cloneUrl $sourceCodePath
    git clone --depth=1 -b master $cloneUrl $sourceCodePath
}

# Notify user that all repositories have been cloned
Write-Host "All repositories have been cloned to the local computer"

