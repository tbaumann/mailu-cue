package mailu

deployment: smtp: {
	spec: {
		template: {
			metadata: labels: tier: "backend"
			spec: {
				containers: [{
					image: "mailu/postfix:master"
					envFrom: [{
						configMapRef: name: "config"
					}]
					resources: {
						requests: {
							memory: "2Gi"
							cpu:    "500m"
						}
						limits: {
							memory: "2Gi"
							cpu:    "500m"
						}
					}
					volumeMounts: [{
						mountPath: "/queue"
						name:      "maildata"
						subPath:   "mailqueue"
					}, {
						mountPath: "/overrides"
						name:      "maildata"
						subPath:   "overrides"
					}]
					ports: [{
						name:          "smtp"
						containerPort: 25
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "smtp-ssl"
						containerPort: 465
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "smtp-starttls"
						containerPort: 587
						protocol:      "TCP"
						_export:       true
					}, {
						name:          "smtp-auth"
						containerPort: 10025
						protocol:      "TCP"
					}]
				}]
				volumes: [{
					name: "maildata"
					persistentVolumeClaim: claimName: "mail-storage"
				}]
			}
		}
	}
}
