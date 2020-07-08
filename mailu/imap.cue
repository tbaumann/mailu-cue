package mailu

deployment: "imap": {
	spec: {
		template: {
			metadata: labels: tier: "backend"
			spec: {
				containers: [{
					image: "mailu/dovecot:master"
					envFrom: [{
						configMapRef: name: "mailu-config"
					}]
					volumeMounts: [{
						mountPath: "/data"
						name:      "maildata"
						subPath:   "maildata"
					}, {
						mountPath: "/mail"
						name:      "maildata"
						subPath:   "mailstate"
					}, {
						mountPath: "/overrides"
						name:      "maildata"
						subPath:   "overrides"
					}]
					ports: [{
						name:          "imap-auth"
						containerPort: 2102
					}, {
						name:          "imap-transport"
						containerPort: 2525
					}, {
						name:          "pop3"
						containerPort: 110
						_export:       true
					}, {
						name:          "imap-default"
						containerPort: 143
						_export:       true
					}, {
						name:          "sieve"
						containerPort: 4190
						_export:       true
					}]
					resources: {
						requests: {
							memory: "1Gi"
							cpu:    "1000m"
						}
						limits: {
							memory: "1Gi"
							cpu:    "1000m"
						}
					}
				}]
				volumes: [{
					name: "maildata"
					persistentVolumeClaim: claimName: "mail-storage"
				}]
			}
		}
	}
}
