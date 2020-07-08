package mailu

daemonSet: [Name=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "DaemonSet"
	name:       Name
	metadata: name: Name
	spec: template: spec: containers: [{
		name:            Name
		imagePullPolicy: "Always"
	}]
}

statefulSet: [Name=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"
	name:       Name
}

configMap: [Name=_]: {
	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata: name: Name
	data: {
		// Mailu main configuration file
		//
		// Most configuration variables can be modified through the Web interface,
		// these few settings must however be configured before starting the mail
		// server and require a restart upon change.
		//##################################
		// Common configuration variables
		//##################################
		// Set this to the path where Mailu data and configuration is stored
		ROOT: string | *"/mailu"

		// Mailu version to run (1.0, 1.1, etc. or master)
		VERSION: string | *"master"

		// Set to a randomly generated 16 bytes string
		SECRET_KEY: string

		// Address where listening ports should bind
		BIND_ADDRESS4: string | *"127.0.0.1"
		//BIND_ADDRESS6: "::1"
		// Main mail domain
		DOMAIN: string

		// Hostnames for this server, separated with comas
		HOSTNAMES: string

		// Postmaster local part (will append the main mail domain)
		POSTMASTER: string | *"admin"

		// Choose how secure connections will behave (value: letsencrypt, cert, notls, mail, mail-letsencrypt)
		TLS_FLAVOR: *"cert" | "letsencrypt" | "notls" | "mail" | "mail-letsencrypt"

		// Authentication rate limit (per source IP address)
		AUTH_RATELIMIT: string | *"10/minute;1000/hour"

		// Opt-out of statistics, replace with "True" to opt out
		DISABLE_STATISTICS: *"False" | "False"

		//##################################
		// Kubernetes configuration
		//##################################
		// Use Kubernetes Ingress Controller to handle all actions on port 80 and 443
		// This way we can make use of the advantages of the cert-manager deployment
		KUBERNETES_INGRESS: *"true" | "false"

		// POD_ADDRESS_RANGE is normally provided by default with Kubernetes
		// Only use this value when you are using Flannel, Calico or a special kind of CNI
		// Provide the IPs of your network interface or bridge which is used for VXLAN network traffic
		// POD_ADDRESS_RANGE: *""

		//##################################
		// Optional features
		//##################################
		// Expose the admin interface (value: true, false)
		ADMIN: *"true" | "false"
		// Run the admin interface in debug mode
		//DEBUG: "True"
		// Choose which webmail to run if any (values: roundcube, rainloop, none)
		WEBMAIL: *"roundcube" | "rainloop" | "none"

		// Dav server implementation (value: radicale, none)
		WEBDAV: *"radicale" | "none"

		// Antivirus solution (value: clamav, none)
		ANTIVIRUS: *"clamav" | "none"

		//##################################
		// Mail settings
		//##################################
		// Message size limit in bytes
		// Default: accept messages up to 50MB
		MESSAGE_SIZE_LIMIT: string | *"5000000"

		// Will relay all outgoing mails if configured
		//RELAYHOST=
		// This part is needed for the XCLIENT login for postfix. This should be the POD ADDRESS range
		FRONT_ADDRESS: "front.mailu-mailserver.svc.cluster.local"

		// This value  is needed by the webmail to find the correct imap backend
		IMAP_ADDRESS: "imap.mailu-mailserver.svc.cluster.local"

		// This value is used by Dovecot to find the Redis server in the cluster
		REDIS_ADDRESS: "redis.mailu-mailserver.svc.cluster.local"

		// Fetchmail delay
		FETCHMAIL_DELAY: string | *"600"

		// Recipient delimiter, character used to delimiter localpart from custom address part
		// e.g. localpart+custom@domain;tld
		RECIPIENT_DELIMITER: string | *"+"

		// DMARC rua and ruf email
		DMARC_RUA: string | *"root"
		DMARC_RUF: string | *"root"

		// Welcome email, enable and set a topic and body if you wish to send welcome
		// emails to all users.
		WELCOME:         *"true" | "false"
		WELCOME_SUBJECT: string | *"Welcome to your new email account"
		WELCOME_BODY:    string | *"Welcome to your new email account, if you can read this, then it is configured properly!"

		//##################################
		// Web settings
		//##################################
		// Path to the admin interface if enabled
		// Kubernetes addition: You need to change ALL the ingresses, when you want this URL to be different!!!
		WEB_ADMIN: string | *"/admin"

		// Path to the webmail if enabled
		// Currently, this is not used, because we intended to use a different subdomain: webmail.example.com
		// This option can be added in a feature release
		WEB_WEBMAIL: string | *"/webmail"

		// Website name
		SITENAME: string | *"Mailu"

		// Linked Website URL
		WEBSITE: string

		// Registration reCaptcha settings (warning, this has some privacy impact)
		// RECAPTCHA_PUBLIC_KEY=
		// RECAPTCHA_PRIVATE_KEY=
		// Domain registration, uncomment to enable
		// DOMAIN_REGISTRATION=true
		//##################################
		// Advanced settings
		//##################################
		// Create an admin account if it does not exist yet. It will also create the email domain for the account.
		INITIAL_ADMIN_ACCOUNT: string
		INITIAL_ADMIN_DOMAIN:  string
		INITIAL_ADMIN_PW:      string

		// Docker-compose project name, this will prepended to containers names.
		COMPOSE_PROJECT_NAME: string | *"mailu"

		// Default password scheme used for newly created accounts and changed passwords
		// (value: SHA512-CRYPT, SHA256-CRYPT, MD5-CRYPT, CRYPT)
		PASSWORD_SCHEME: *"SHA512-CRYPT" | "SHA256-CRYPT" | "MD5-CRYPT" | "CRYPT"

		// Header to take the real ip from
		//REAL_IP_HEADER:
		// IPs for nginx set_real_ip_from (CIDR list separated by commas)
		//REAL_IP_FROM:
		// Host settings
		HOST_IMAP:            "imap.mailu-mailserver.svc.cluster.local"
		HOST_POP3:            "imap.mailu-mailserver.svc.cluster.local"
		HOST_SMTP:            "smtp.mailu-mailserver.svc.cluster.local"
		HOST_AUTHSMTP:        "smtp.mailu-mailserver.svc.cluster.local"
		HOST_WEBMAIL:         "webmail.mailu-mailserver.svc.cluster.local"
		HOST_ADMIN:           "admin.mailu-mailserver.svc.cluster.local"
		HOST_WEBDAV:          "webdav.mailu-mailserver.svc.cluster.local:5232"
		HOST_ANTISPAM_MILTER: "antispam.mailu-mailserver.svc.cluster.local:11332"
		HOST_ANTISPAM_WEBUI:  "antispam.mailu-mailserver.svc.cluster.local:11334"
		HOST_ANTIVIRUS:       "antivirus.mailu-mailserver.svc.cluster.local:3310"
		HOST_REDIS:           "redis.mailu-mailserver.svc.cluster.local"
	}
}

deployment: [Name=_]: _spec & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	name:       Name
	metadata: name: Name
	spec: {
		selector: matchLabels: app: Name
		template: {
			metadata: labels: app:  Name
			metadata: labels: role: *"mail" | string
			replicas: *1 | int
			spec: containers: [{
				name:            Name
				imagePullPolicy: "Always"
			}]
		}
	}
}

service: [Name=_]: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: Name
		labels: {
			app:  Name
			role: "mail"
			tier: *"backend" | string
		}
	}
	spec: {
		ports: [...{
			port:     int
			protocol: *"TCP" | "UDP"
			name:     string | *"client"
		}]
		selector: metadata.labels
	}
}

_spec: spec: template: spec: containers: [...{
	ports: [...{
		_export: true | *false // include the port in the service
	}]
}]

for x in [deployment, daemonSet, statefulSet] for k, v in x {
	// FIXME: Could possibly overwrite service:
	// Check that
	service: "\(k)": {
		spec: selector: v.spec.template.metadata.labels

		spec: ports: [
			for c in v.spec.template.spec.containers
			for p in c.ports
			if p._export {
				let Port = p.containerPort // Port is an alias
				port:       *Port | int
				targetPort: *Port | int
			},
		]
	}
}
