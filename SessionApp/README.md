This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.

# Ahmed's Notes about link with iOS

Serving Next.js at /groups/[groupid] on Your WordPress Domain
You want:www.mytherapymuse.com/groups/[groupid]to serve the page currently athttp://146.190.47.95:8080/groups/[groupid](which is your Next.js app).

# Variables to pass from iOS app to Next.js App

Essential Variables
• groupid (required): The unique group identifier (used in the URL and as a prop)
• groupName: The name of the group
• groupImage or groupImageUrl: The image selected by the user for the group

Other Possible Variables
• userId: The ID of the user joining or viewing the group
• userName: The name of the user
• authToken or sessionToken: For authentication (if needed)
• referrer: Where the user came from (optional, for analytics)
Any other group metadata (description, members, etc.)

## Server Packages and Their Purpose

- **nginx**: Web server and reverse proxy for serving WordPress and proxying Next.js routes.
- **nodejs & npm**: JavaScript runtime and package manager for running and managing the Next.js app.
- **next.js**: React framework for building the group-sharing web app.
- **pm2**: Process manager to keep the Next.js app running in the background.
- **php8.3-fpm**: PHP FastCGI Process Manager for WordPress PHP processing.
- **certbot**: Tool for obtaining and renewing free SSL certificates from Let's Encrypt.
- **net-tools**: Networking utilities for troubleshooting (e.g., `netstat`).
- **curl**: Command-line tool for testing HTTP requests.
- **ufw**: (Optional) Firewall management tool.
