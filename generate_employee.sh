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
  echo "[LinkedIn](${linkedin})" >> $employee_page
  echo "[GitHub](${github})" >> $employee_page
  echo "" >> $employee_page

  echo "Employee markdown page has been generated at ./content/employees/${first_lower}_${last_lower}.md"
else
  echo "Something went wrong; try again."
fi
