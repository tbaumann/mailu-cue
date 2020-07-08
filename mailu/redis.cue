package mailu

deployment: redis: {
	spec: {
		template: {
			metadata: labels: tier: "backend"
			spec: {
				containers: [{
					image:           "redis:5-alpine"
					volumeMounts: [{
						mountPath: "/data"
						name:      "redisdata"
					}]
					ports: [{
						containerPort: 6379
						name:          "redis"
						protocol:      "TCP"
					}]
					resources: {
						requests: {
							memory: "200Mi"
							cpu:    "100m"
						}
						limits: {
							memory: "300Mi"
							cpu:    "200m"
						}
					}
				}]
				volumes: [{
					name: "redisdata"
					persistentVolumeClaim: claimName: "redis-hdd"
				}]
			}
		}
	}
}
