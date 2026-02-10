module.exports = {
  apps: [
    {
      name: 'careerwiki',
      script: 'npx',
      args: 'wrangler pages dev dist --d1=careerwiki --local --ip 0.0.0.0 --port 3000',
      env: {
        NODE_ENV: 'development',
        PORT: 3000
      },
      cwd: '/home/user/webapp',
      watch: false,
      instances: 1,
      exec_mode: 'fork'
    }
  ]
}