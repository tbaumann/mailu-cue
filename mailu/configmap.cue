package mailu

configMap: config: {
	data: {
		// Set to a randomly generated 16 bytes string
		SECRET_KEY: "dieW3On9UB4chaok"

		// Main mail domain
		DOMAIN: "tilman.baumann.name"

		// Hostnames for this server, separated with comas
		HOSTNAMES: "mail.tilman.baumann.name"

		// POD_ADDRESS_RANGE is normally provided by default with Kubernetes
		// Only use this value when you are using Flannel, Calico or a special kind of CNI
		// Provide the IPs of your network interface or bridge which is used for VXLAN network traffic
		POD_ADDRESS_RANGE: "10.1.0.0/16"

		// Dav server implementation (value: radicale, none)
		WEBDAV: "none"

		// Antivirus solution (value: clamav, none)
		ANTIVIRUS: "none"

		//##################################
		// Mail settings
		//##################################
		// Message size limit in bytes
		// Default: accept messages up to 50MB
		MESSAGE_SIZE_LIMIT: "50000000"

		// Linked Website URL
		WEBSITE: "https://mail.tilman.baumann.name"

		// Registration reCaptcha settings (warning, this has some privacy impact)
		// RECAPTCHA_PUBLIC_KEY=
		// RECAPTCHA_PRIVATE_KEY=
		// Domain registration, uncomment to enable
		// DOMAIN_REGISTRATION=true
		//##################################
		// Advanced settings
		//##################################
		// Create an admin account if it does not exist yet. It will also create the email domain for the account.
		INITIAL_ADMIN_ACCOUNT: "tilmanb"
		INITIAL_ADMIN_DOMAIN:  "tilman.baumann.name"
		INITIAL_ADMIN_PW:      "mjkd15d3+56i"
	}
}
