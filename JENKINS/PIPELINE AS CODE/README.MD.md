https://gitlab.com/nanuchi/techworld-js-docker-demo-app/-/tree/dev


### jenkins configurations as code plugin
Configuration as Code

### jenkins configurations as code links
* [Configuration as Code](https://plugins.jenkins.io/configuration-as-code/)

* [Jenkins Pipeline Documentation](https://anoni.sh/jenkins-pipeline)

* [Jenkins Pipeline Syntax](https://anoni.sh/pipeline-syntax)

* [Jenkins Pipeline steps](https://anoni.sh/pipeline-steps)

https://github.com/devbyaccident/demo-shared-pipeline

https://github.com/devbyaccident/azure-voting-app-redis/blob/master/Jenkinsfile

### Declarative pipeline Vs Scripted Pipeline
- A declarative pipeline has a structure defined already that needs to be followed while scripting pipeline is a groovy script that does not have a structure. 

- Declarative pipeline start with the **pipeline definition** while scripted pipeline start with **node definition**




### Running hello world
- **Agent** indicates that Jenkins should allocate an executor or slave to run the pipeline.
- **Stage:** it is a section of the pipeline such as build, test and so on
- **Steps:** it is the specific instruction to execute the stage.
- **Pipeline:** it is a series of tasks required to build, test and deploy an application from source control into dev, qa and prod.

```s
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
    }
}
```

### Pipeline structure
```s
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
        stage('build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('test') {
            steps {
              echo "Testing the application........" 
            }
        }
        stage('package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('deploy') {
            steps {
               echo "Deploying the application........"
            }
        }
    }
}
```

### Running a shell script in the pipeline
```s
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Run shell commands') {
            steps {
               sh '''
                 #!/bin/bash
                 echo "hello world" 
                 ls -la
                 cat /etc/*release
                ''' 
            }
        }
    }
}
```

```s
pipeline {
    agent any
    stages {
        stage('Hello World') {
            steps {
                echo "Hello World"
            }
        }
        stage('Run shell commands') {
            steps {
               sh '''
                #! /bin/bash

                # Uninstall old versions
                sudo yum remove docker \\
                                docker-client \\
                                docker-client-latest \\
                                docker-common \\
                                docker-latest \\
                                docker-latest-logrotate \\
                                docker-logrotate \\
                                docker-engine

                # this will download the script package to install docker
                curl -fsSL https://get.docker.com -o get-docker.sh
                # this will install the package
                sudo sh get-docker.sh

                sudo systemctl enable docker
                sudo systemctl start docker
                sudo docker run hello-world
                sudo docker run docker/whalesay cowsay hello-world!
                ''' 
            }
        }
    }
}
```

### post action
**Post:**
- This helps execute some logic after all stages are executed.
- It can be very helpful to notify the team about the status of the build such as sending **out notification**.

**We have 3 post build condition:**
- **Always:** this will always execute no matter if the build failed or succeed.
- **Success:** this will execute only if the build succeeded.
- **Failure:** this will execute only if the build failed.

```s
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              echo "Cloning the source code........" 
            }
        }
        stage('compile') {
            steps {
               echo "Compiling the application........" 
            }
        }
        stage('build') {
            steps {
               echo "Building the application........"
            }
        }
        stage('test') {
            steps {
              echo "Testing the application........" 
            }
        }
        stage('package') {
            steps {
               echo "Packaging the application........"
            }
        }
        stage('deploy') {
            steps {
               echo "Deploying the application........"
            }
        }
    }
    post {
        always {
            echo "This will always execute no matter if the build failed or succeed"
        }
        success {
            echo "This will execute only if the build succeeded"
        }
        failure {
            echo "This will execute only if the build failed"
        }
    }
}
```

### User define variables
* It most be in double quote like echo "Building version ${NEW_VERSION}" and not echo 'Building version ${NEW_VERSION}'
```s
pipeline {
    agent any
    environment {
      NEW_VERSION = '1.3.0'
    }
    stages {
        
        stage('Build') {
            steps {
               echo "Building the application........" 
               echo "Building version: ${NEW_VERSION}" 
            }
        }
    }
}



### Build in variables or environment variables
* [jenkins-url][/env-vars.html/]
* Example: http://10.0.0.3:8080/env-vars.html/

```s
BRANCH_NAME
GIT_BRANCH
GIT_URL
BRANCH_NAME

pipeline {
    agent any
    stages {
        stage('Displying some Env') {
            steps {
                echo "The build number is: ${BUILD_NUMBER}"
                echo "The job number is: ${JOB_NAME}"
                echo "The Jenkins home directory is: ${JENKINS_HOME}"
                echo "The Jenkins URL is: ${JENKINS_URL}"
                echo "The build URL is: ${BUILD_URL}"
                echo "The job URL is: ${JOB_URL}"
                echo "The workspace is: ${WORKSPACE}"
            }
        }
    }
}
```

### Get the list of all the plugins
* [jenkins-url][/script]
* Example: http://10.0.0.3:8080/script
* Hit enter, paste the code below and run

```s
def pluginList = new ArrayList(Jenkins.instance.pluginManager.plugins)
pluginList.sort { it.getShortName() }.each{
  plugin -> 
    println ("${plugin.getShortName()}: ${plugin.getVersion()}")
}
```

### Plugins
configuration-as-code
docker-build-publish
matrix-auth
publish-over-ssh
aws-credentials
maven-plugin
role-strategy
github
pipeline-utility-steps



### Get credentials values
* add _USR and _PSW on the variable that you set such as `ANSIBLE_HOST_USR` and `ANSIBLE_HOST_PSW`

```s
pipeline {
    agent any
    environment {
      ANSIBLE_HOST = credentials('ansadmin-host')
    }
    stages {
        stage('deploy') {
          steps {
            echo "Ansible host username is: ${ANSIBLE_HOST_USR}"
            echo "Ansible host password is: ${ANSIBLE_HOST_PSW}"
          }
        }
    }
}

### Better away of doing it in single quote
pipeline {
    agent any
    environment {
      ANSIBLE_HOST = credentials('ansadmin-host')
    }
    stages {
        stage('deploy') {
          steps {
            sh ('echo Ansible host username is: ${ANSIBLE_HOST_USR}')
            sh ('echo Ansible host password is: ${ANSIBLE_HOST_PSW}')
          }
        }
    }
}
```


### Check out the code
```s
pipeline {
    agent any
    stages {
        stage('Chechout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/dev']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/leonardtia1/jenkins.git']]])
            }
        }
    }
}
```

post {
        always {
            echo "This will always execute no matter if the build failed or succeed"
        }
        success {
            echo "This will execute only if the build succeeded"
        }
        failure {
            echo "This will execute only if the build failed"
        }
    }
}




### Email notification

```s

// Declarative //
pipeline {
	agent any
	stages {
		stage('Test') {
			steps {
				sh 'cat /etc/*release'
			}
		}
	}
	post {
		failure {
			mail bcc: '', body: '''Hi 
			Please Check Jenkins the job failed.''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job Notification', to: 'tiajearad44@gmail.com'
		}
	}
}


// Declarative //
pipeline {
	agent any
	stages {
		stage('Test') {
			steps {
				sh 'cat /etc/*release....'
			}
		}
	}
	post {
		failure {
			mail bcc: '', body: '''Hi 
			Please Check Jenkins the job failed.''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job Notification', to: 'tiajearad44@gmail.com'
		}
	}
}
```



### Condictions
```s
BRANCH_NAME == "dev" || BRANCH_NAME == "prod"
BRANCH_NAME == "dev" || BRANCH_NAME == "prod" || BRANCH_NAME == "qa"
BRANCH_NAME == "dev" && BRANCH_NAME == "prod"
BRANCH_NAME == "dev" && BRANCH_NAME == "prod" && BRANCH_NAME == "qa"

BRANCH_NAME != "master" && BRANCH_NAME != "prod"

BRANCH_NAME == "dev" && CODE_CHANGES == true


env.BRANCH_NAME == "dev" || env.BRANCH_NAME == "prod"
env.BRANCH_NAME == "dev" || env.BRANCH_NAME == "prod" || env.BRANCH_NAME == "qa"
env.BRANCH_NAME == "dev" && env.BRANCH_NAME == "prod"
env.BRANCH_NAME == "dev" && env.BRANCH_NAME == "prod" && env.BRANCH_NAME == "qa"

env.BRANCH_NAME != "master" && env.BRANCH_NAME != "prod"

env.BRANCH_NAME == "dev" && env.CODE_CHANGES == true
```


