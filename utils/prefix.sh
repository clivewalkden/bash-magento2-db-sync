#!/usr/bin/env bash

# Run the prefix information to the sequence table
echo
echo -e "${txt_blue}  Adding prefix to Magento Orders, Invoices, Credit Memo's and Shipping Notes.${txt_end}"
echo

mysql -h$DB_HOST -u$DB_USER -p$DB_PASS -D$DB_DBASE <<EOF
UPDATE sales_sequence_profile SET prefix = IFNULL(CONCAT("TEST", prefix, "-"), "TEST-")
EOF
