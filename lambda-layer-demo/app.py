from mylayer import hello_from_layer

def handler(event, context):
    return {
        "statusCode": 200,
        "body": hello_from_layer()
    }
