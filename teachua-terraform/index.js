const HTTPS = require('https');
const { SSMClient, GetParameterCommand } = require("@aws-sdk/client-ssm");

const ssm = new SSMClient({ region: process.env.AWS_REGION });

exports.handler = async (event) => {
    // 1. Retrieve the Discord URL from Parameter Store
    const paramResult = await ssm.send(new GetParameterCommand({
        Name: process.env.DISCORD_WEBHOOK_PARAM,
        WithDecryption: true
    }));
    const discordUrl = paramResult.Parameter.Value;

    // 2. Parsing the message from CloudWatch
    const snsMessage = JSON.parse(event.Records[0].Sns.Message);
    const alarmName = snsMessage.AlarmName;
    const newState = snsMessage.NewStateValue; // ALARM or OK
    const reason = snsMessage.NewStateReason;

    // 3. Creating an attractive Discord card
    const color = newState === 'ALARM' ? 15158332 : 3066993; // Red or green
    const emoji = newState === 'ALARM' ? '🚨' : '✅';

    const discordPayload = JSON.stringify({
        embeds: [{
            title: `${emoji} Alert State Changed: ${newState}`,
            description: `**Alarm:** ${alarmName}\n**Reason:** ${reason}`,
            color: color,
            timestamp: new Date().toISOString()
        }]
    });

    // 4. Sending to Discord
    return new Promise((resolve, reject) => {
        const req = HTTPS.request(discordUrl, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        }, (res) => {
            res.on('data', () => resolve());
        });
        req.on('error', (e) => reject(e));
        req.write(discordPayload);
        req.end();
    });
};
