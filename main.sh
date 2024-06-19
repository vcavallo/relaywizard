#!/bin/bash

# Source the print_colors.sh script to use color printing functions
source ./lib/print_colors.sh

# Source the scripts containing the functions
source ./install_packages.sh
source ./configure_nginx_http.sh
source ./get_certificates.sh
source ./configure_nginx_https.sh

# Prompt for domain name if not provided as an argument
if [ -z "$1" ]; then
	read -p "Enter the domain name for the nostr relay site (e.g., example.com): " domain_name
else
	domain_name="$1"
fi

# Prompt for email address if not provided as an argument
if [ -z "$2" ]; then
	read -p "Enter the email address for SSL certificate registration: " email
else
	email="$2"
fi

# Call the function to install packages
print_info "Running install_packages function..."
install_packages

# Call the function to configure nginx for HTTP
print_info "Running configure_nginx_http function..."
configure_nginx_http "$domain_name"

# Call the function to get SSL certificates
print_info "Running get_certificates function..."
get_certificates "$domain_name" "$email"

# Call the function to configure nginx for HTTPS
print_info "Running configure_nginx_https function..."
configure_nginx_https "$domain_name"

print_success "Setup completed successfully."
