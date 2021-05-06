# Create an IAM user
aws iam create-user --user-name Michael

# Create an IAM group
aws iam create-group --group-name Michael-Group

# Add user to group
aws iam add-user-to-group --user-name Michael --group-name Michael-Group
