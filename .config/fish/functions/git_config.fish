function git_config --description "Configure Git"
echo -n "
  ===================================
        * Git Configuration *
  -----------------------------------
  Please input Git Username: "

read username

echo -n "
  -----------------------------------
  Please input Git Email: "

read email

echo -n "
  -----------------------------------
  Done!
  ===================================
  "

git config --global user.name "${username}"
git config --global user.email "${email}"
end
