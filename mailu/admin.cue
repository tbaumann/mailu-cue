package mailu

deployment: admin: spec: template: {
	metadata: labels: tier: "backend"
	spec: {
		containers: [{
			image: "mailu/admin:master"
			envFrom: [{
				configMapRef: name: "config"
			}]
			volumeMounts: [{
				name:      "maildata"
				mountPath: "/data"
				subPath:   "maildata"
			}, {
				name:      "maildata"
				mountPath: "/dkim"
				subPath:   "dkim"
			}]
			ports: [{
				name:          "http"
				containerPort: 80
				protocol:      "TCP"
				_export:       true
			}]
			resources: {
				requests: {
					memory: "500Mi"
					cpu:    "500m"
				}
				limits: {
					memory: "500Mi"
					cpu:    "500m"
				}
			}
		}]
		volumes: [{
			name: "maildata"
			persistentVolumeClaim: claimName: "mail-storage"
		}]
	}
}
