#!/bin/bash

# Set variables
IMAGE_NAME="example-python-job"
IMAGE_TAG="latest"
DOCKERFILE_PATH="./Dockerfile"
JOB_NAME="example-python-job-$(date +%s)"

# Step 1: Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKERFILE_PATH .


# Step 2: Create a Kubernetes Job YAML manifest
JOB_YAML=$(cat <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: $JOB_NAME
spec:
  template:
    spec:
      containers:
      - name: python
        image: $IMAGE_NAME:$IMAGE_TAG
        command: ["python", "app/main.py"]
        args: ["$@"]
        imagePullPolicy: Never
      restartPolicy: Never
EOF
)

# Save the Job YAML to a temporary file
TEMP_JOB_FILE="temp-job.yaml"
echo "$JOB_YAML" > $TEMP_JOB_FILE

# Step 3: Apply the Job to the Kubernetes cluster
echo "Applying Kubernetes Job..."
kubectl apply -f $TEMP_JOB_FILE

# Clean up
rm $TEMP_JOB_FILE

echo "Job $JOB_NAME created and applied successfully."
