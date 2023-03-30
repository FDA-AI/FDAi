import { PrismaClient } from "@prisma/client"
const prisma = new PrismaClient()

async function main() {
    const connectors = await prisma.connectors.findMany()
    const loginConnectors = connectors.filter((connector) =>
        connector.name === "googleplus" ||
        connector.name === "facebook" ||
        connector.name === "twitter" ||
        connector.name === "github")
    const connectorIds = loginConnectors.map((connector) => connector.id)
    // ... you will write your Prisma Client queries here
    const connections = await prisma.connections.findMany({
          include: {
              connector: true,
              human: true,
          },
          where: {
              connector_id: {
                  in: connectorIds,
              },
              connector_user_id: {
                  equals: null,
              },
          },
      })
    for (const connectionsKey in connections) {
        if (!connections.hasOwnProperty(connectionsKey)) {
            continue
        }
        const connection = connections[connectionsKey]
        const connector = connection.connector
        const connectorName = connector.name
        console.log(`Connector name: ${connectorName} - ${connection.human.email}`)
        const meta = await prisma.wp_usermeta.findMany({
            where: {
                meta_key: {
                    contains: "%" + connectorName + "%",
                },
                user_id: {
                    equals: connection.user_id,
                },
            },
        })
        for(const metaKey in meta) {
            if (!meta.hasOwnProperty(metaKey)) {
                continue
            }
            const metaItem = meta[metaKey]
            if(metaItem.meta_key === connectorName + "_connector_user_id") {
                const connectorUserId = metaItem.meta_value
                const res = await prisma.connections.update({
                    data: {
                        connector_user_id: connectorUserId,
                    },
                    where: {
                        id: connection.id,
                    },
                })
                console.log(`Updated connection ${connection.id} with connector_user_id ${metaItem.meta_value}. Result: ${res}`)
            }

        }
    }
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })
