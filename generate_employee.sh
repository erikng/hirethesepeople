#!/bin/bash
date=$(date '+%Y-%m-%d')

echo -e "This is a (crude) helper script to easily generate a new employee page on the site. Please fill in the fields with your data and a new markdown page will be generated for you.\n"

echo "First name:"
read first
first_lower=$(echo "$first" | awk '{print tolower($0)}')

echo "Last name:"
read last
last_lower=$(echo "$last" | awk '{print tolower($0)}')

echo "Former company:"
read company
company_lower=$(echo "$company" | awk '{print tolower($0)}')

echo "Role:"
read role

echo "About:"
read about

echo "Experience/skills:"
read experience

echo "LinkedIn URL:"
read linkedin

echo "GitHub URL:"
read github

echo -e "\n\n"
echo "Please review the following:"
echo "First name: $first"
echo "Last name: $last"
echo "Former company: $company"
echo "Role: $role"
echo "About: $about"
echo "Experience/skills: $experience"
echo "LinkedIn URL: $linkedin"
echo "GitHub URL: $github"
echo -e "\nIs this correct (y/n)?"
read correct

if [[ $correct == "y" ]]; then
  echo "Generating employee markdown page..."
  
  echo "---" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "title: \"${first} ${last}\"" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "date: \"${date}\"" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "draft: false" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "companies: [" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo -e "\t\t\"${company_lower}\"" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "]" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "roles: [" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo -e "\t\t\"${role}\"" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "]" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "type: \"post\"" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "---" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "## About me" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "${about}" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "## Experience" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "${experience}" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "## Contact Me" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "[LinkedIn](${linkedin})" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "[GitHub](${github})" >> "./content/employees/${first_lower}_${last_lower}.md"
  echo "" >> "./content/employees/${first_lower}_${last_lower}.md"

  echo "Employee markdown page has been generated at ./content/employees/${first_lower}_${last_lower}.md"
  
else
  echo "Something went wrong; try again."
fi
