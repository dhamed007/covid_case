import os
import subprocess

def clone_cdc_repo(cdc_repo_url, enterprise_github_username, enterprise_repo_name):
    enterprise_github_token = os.getenv("ENTERPRISE_GITHUB_TOKEN")
    
    # Clone the repository from CDC GitHub
    try:
        subprocess.run(["git", "clone", cdc_repo_url])
        print("Repository cloned successfully from CDC GitHub.")
    except subprocess.CalledProcessError as e:
        print("Error cloning repository from CDC GitHub:", e)
        exit(1)
    
    # Change directory to the cloned repository
    os.chdir(enterprise_repo_name)
    
    # Add the enterprise GitHub repository as a remote
    enterprise_github_url = f"https://{enterprise_github_username}:{enterprise_github_token}@github.enterprise.com/{enterprise_github_username}/{enterprise_repo_name}.git"
    try:
        subprocess.run(["git", "remote", "add", "enterprise", enterprise_github_url])
        print("Enterprise GitHub remote added successfully.")
    except subprocess.CalledProcessError as e:
        print("Error adding enterprise GitHub remote:", e)
        exit(1)
    
    # Push the code to the enterprise GitHub repository
    try:
        subprocess.run(["git", "push", "enterprise", "--mirror"])
        print("Code successfully pushed to enterprise GitHub.")
    except subprocess.CalledProcessError as e:
        print("Error pushing code to enterprise GitHub:", e)
        exit(1)
    
    # Create catalog-info.yml file
    with open("catalog-info.yml", "w") as file:
        file.write("# Enter your catalog information here")

if __name__ == "__main__":
    # CDC GitHub repository details
    cdc_repo_url = "https://github.com/CDCgov/covid_case_privacy_review.git"
    
    # Enterprise GitHub credentials and repository details
    enterprise_github_username = "your_github_username"
    enterprise_repo_name = "your-enterprise-repo"  # Replace with the name of your enterprise repo
    
    # Clone CDC repo, push to enterprise GitHub, and create catalog-info.yml
    clone_cdc_repo(cdc_repo_url, enterprise_github_username, enterprise_repo_name)
---



  
