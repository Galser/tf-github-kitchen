repo_url = attribute('full_repo_web_path')
repo_desc = attribute('repo_description')
control 'check_github_repo_url' do

    describe http(repo_url) do
      its('status') { should cmp 200 }
      its('body') { should match repo_desc }
    end
  
  end