
## Multibranch Pipeline job configuration
* [Create Multibranch Pipeline with Git](https://www.youtube.com/watch?v=tuxO7ZXplRE&t=1s)

* [Trigger Jenkins Build automatically](https://www.youtube.com/watch?v=CmwTPxdx24Y)
```
.* 

.*(dev|dev1|dev2|qa|).*

^dev1|dev2|dev3|qa1|qa2.*$

^prod1|prod2.*$

https://github.com/leonardtia1/pipeline-groovy-test.git
```

## Jenkins Backup jobs
```sh
echo 'Creating a tar file'
cd /var/lib/jenkins/jobs/
tar -cvf jenkins_backup.tar .
echo 'Upload jenkins_backup.tar to S3 bucket'
aws s3 cp jenkins_backup.tar s3://jenkins-backup-job/
echo 'Remove files after succesful upload to S3'
rm -rf jenkins_backup.tar
```