from twitter_credentials import consumer_key, consumer_secret, access_token, access_token_secret
import tweepy
import json
from kafka import KafkaProducer

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token,access_token_secret)
api = tweepy.API(auth,wait_on_rate_limit=True)

def user_timeline(username):
    twet_list = []
    for t in tweepy.Cursor(api.user_timeline, screen_name=username, count=60, tweet_mode='extended').items():
        t_json = json.dumps(t._json)
        twet_list.append(json.loads(t_json))
    return twet_list

t_list = user_timeline('sanbenito')

producer = KafkaProducer(bootstrap_servers=['localhost:9092'])
future = producer.send('bad-bunny', b'raw_bytes7')
producer = KafkaProducer(value_serializer=lambda m: json.dumps(m).encode('ascii'))
producer.send('json-topic', {'key': 'value'})