package mailu

daemonSet: front: {
	metadata: {
		labels: {
			component: "ingress-controller"
			type:      "nginx"
		}
	}
	spec: {
		selector: matchLabels: {
			component: "ingress-controller"
			type:      "nginx"
		}
		template: {
			metadata: labels: {
				component: "ingress-controller"
				type:      "nginx"
			}
			spec: {
				dnsPolicy:                     "ClusterFirstWithHostNet"
				restartPolicy:                 "Always"
				terminationGracePeriodSeconds: 60
				containers: [{
					image: "mailu/nginx:master"
					envFrom: [{
						configMapRef: name: "config"
					}]
					volumeMounts: [{
						name:      "certs"
						mountPath: "/certs"
					}]
					ports: [{
						name:          "pop3"
						containerPort: 110
						hostPort:      110
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "pop3s"
						containerPort: 995
						hostPort:      995
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "imap"
						containerPort: 143
						hostPort:      143
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "imaps"
						containerPort: 993
						hostPort:      993
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "smtp"
						containerPort: 25
						hostPort:      25
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "smtps"
						containerPort: 465
						hostPort:      465
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "smtpd"
						containerPort: 587
						hostPort:      587
						protocol:      "TCP"
						_export:       true
					}, {
						// internal services (not exposed externally)
						name:          "smtp-auth"
						containerPort: 10025
						protocol:      "TCP"
					}, {
						name:          "imap-auth"
						containerPort: 10143
						protocol:      "TCP"
					}, {
						name:          "auth"
						containerPort: 8000
						protocol:      "TCP"
					}, {
						name:          "http"
						containerPort: 80
						protocol:      "TCP"
					}]
					resources: {
						requests: {
							memory: "100Mi"
							cpu:    "100m"
						}
						limits: {
							memory: "200Mi"
							cpu:    "200m"
						}
					}
				}]
				volumes: [{
					name: "certs"
					secret: {
						items: [{
							key:  "tls.crt"
							path: "cert.pem"
						}, {
							key:  "tls.key"
							path: "key.pem"
						}]
						secretName: "letsencrypt-certs-all"
					}
				}]
			}
		}
	}
}
