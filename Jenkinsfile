pipeline
{
	agent
	{
		label "OSX && xcode"
	}

	options
	{     
		// Skip default checkout since checkout is done at specific node.
		skipDefaultCheckout()

		// Disable concurrent builds.
		disableConcurrentBuilds()

		// Discard old builds.     
		buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '10'))
	}

	stages
	{
		stage('Checkout Source')
		{
			steps
			{
				// Delete the existing build directory if exists.
				deleteDir()

				checkout scm
			}
		}

		stage('Build App')
		{
			steps
			{
				sh "xcodebuild -scheme WeatherApp -project ./WeatherApp.xcodeproj"
			}
		}
	}
}