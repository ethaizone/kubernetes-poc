# Demo to execute script as K8s job

This is demo by testing on K8s from Docker Desktop.

When you run `./execute-job.sh xxx` then it will create docker image and tag version then it will create new job and apply to K8s. If you plan to use on actual K8s cluster then you need to push docker image on specific docker registry then change image path to correct value.

BTW I added `spec.ttlSecondsAfterFinished` so job will kill after time passed.
