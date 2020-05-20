#!/bin/bash

validate_contact_urls () {
  if [[ $linkedin == "" && $github == "" && $homepage == "" ]]; then
    echo "You must provide at least one 'Contact' URL."
    exit 1
  fi
}

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

echo "You must provide at least one of the following three 'Contact' URL's:"
echo "LinkedIn URL (leave blank if not applicable):"
read linkedin

echo "GitHub URL (leave blank if not applicable):"
read github

echo "Homepage URL(leave blank if not applicable):"
read homepage

validate_contact_urls

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
echo "Homepage URL: $homepage"
echo -e "\nIs this correct (y/n)?"
read correct

if [[ $correct == "y" ]]; then
  echo "Generating employee markdown page..."
  employee_page="./content/employees/${first_lower}_${last_lower}.md"
  echo "---" >> $employee_page
  echo "title: \"${first} ${last}\"" >> $employee_page
  echo "date: \"${date}\"" >> $employee_page
  echo "draft: false" >> $employee_page
  echo "companies: [" >> $employee_page
  echo -e "\t\t\"${company_lower}\"" >> $employee_page
  echo "]" >> $employee_page
  echo "roles: [" >> $employee_page
  echo -e "\t\t\"${role}\"" >> $employee_page
  echo "]" >> $employee_page
  echo "type: \"post\"" >> $employee_page
  echo "---" >> $employee_page
  echo "" >> $employee_page
  echo "## About me" >> $employee_page
  echo "${about}" >> $employee_page
  echo "" >> $employee_page
  echo "## Experience" >> $employee_page
  echo "${experience}" >> $employee_page
  echo "" >> $employee_page
  echo "## Contact Me" >> $employee_page
  if [[ $linkedin != "" ]]; then
    echo "* [LinkedIn](${linkedin})" >> $employee_page
  fi
  if [[ $github != "" ]]; then
    echo "* [GitHub](${github})" >> $employee_page
  fi
  if [[ $homepage != "" ]]; then
    echo "* [Homepage](${homepage})" >> $employee_page
  fi
  echo "" >> $employee_page

  echo "Employee markdown page has been generated at ./content/employees/${first_lower}_${last_lower}.md"
else
  echo "Something went wrong; try again."
  exit 2
fi
