import { SESClient, SendEmailCommand } from '@aws-sdk/client-ses'
import { fromEnv } from '@aws-sdk/credential-provider-env'

const sesClient = new SESClient({
  region: process.env.AWS_DEFAULT_REGION,
  credentials: fromEnv()
})

const sendEmail = async ({ to, subject, text, html }) => {
  const from = process.env.MAIL_FROM_ADDRESS
  try {
    const params = {
      Destination: {
        ToAddresses: [to]
      },
      Message: {
        Body: {
          Text: { Data: text },
          Html: { Data: html }
        },
        Subject: { Data: subject }
      },
      Source: from
    }
    console.log(`Email - ${subject} - ${to}`, { text, html })
    const sendEmailCommand = new SendEmailCommand(params)
    await sesClient.send(sendEmailCommand)
    console.log('Email - ok')
    return true
  } catch (error) {
    console.error('Email - failed:', error)
    return false
  }
}

export { sendEmail }
