# from flask import Flask, request, jsonify
# import torch
# from transformers import GPT2Tokenizer, GPT2LMHeadModel
# from model.rnn_model import RNNModel

# app = Flask(__name__)

# # Load your tokenizer and models
# tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
# model = GPT2LMHeadModel.from_pretrained('gpt2')

# # Define RNN parameters
# input_size = 50257  # Size of the vocabulary for GPT-2
# hidden_size = 256   # Adjust based on your model design
# num_layers = 2     # Adjust based on your model design
# output_size = 50257  # Same as input size, for vocabulary

# # Initialize RNN model
# rnn_model = RNNModel(input_size, hidden_size, num_layers, output_size)

# @app.route('/ask', methods=['POST'])
# def ask():
#     data = request.json
#     user_input = data['message']

#     # Tokenize the input
#     input_ids = tokenizer.encode(user_input, return_tensors='pt')

#     # Get the transformer output
#     with torch.no_grad():
#         transformer_output = model(input_ids)
        
#     # Get the logits
#     logits = transformer_output.logits
    
#     # Select the last logits (for the last token)
#     last_logit = logits[:, -1, :]  # Shape: (batch_size, vocab_size)

#     # Reshape for RNN input
#     rnn_input = last_logit.unsqueeze(0)  # Shape: (1, vocab_size)

#     # Pass through the RNN model
#     rnn_output = rnn_model(rnn_input)

#     # Generate the response
#     response_token_id = torch.argmax(rnn_output, dim=-1).item()
#     response = tokenizer.decode(response_token_id, skip_special_tokens=True)

#     return jsonify({'response': response})

# if __name__ == '__main__':
#     app.run(debug=True)



from flask import Flask, request, jsonify
import torch
from transformers import GPT2Tokenizer, GPT2LMHeadModel
import json
from model.rnn_model import RNNModel

app = Flask(__name__)

# Load your tokenizer and models
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')
model = GPT2LMHeadModel.from_pretrained('gpt2')

# Load FAQ dataset
with open('../backend/data/faq_dataset.json', 'r') as f:
    faq_data = json.load(f)

# Function to get response from FAQ
def get_faq_response(user_input):
    for question, answer in zip(faq_data['questions'], faq_data['answers']):
        if user_input.lower() in question.lower():
            return answer
    return None

# Define RNN parameters
input_size = 50257  # Size of the vocabulary for GPT-2
hidden_size = 256    # Adjust based on your model design
num_layers = 2      # Adjust based on your model design
output_size = 50257  # Same as input size, for vocabulary

# Initialize RNN model
rnn_model = RNNModel(input_size, hidden_size, num_layers, output_size)

@app.route('/ask', methods=['POST'])
def ask():
    data = request.json
    user_input = data['message']

    # Check if the input matches any FAQ question
    faq_answer = get_faq_response(user_input)
    if faq_answer:
        response = faq_answer
    else:
        # If no FAQ match, proceed with the chatbot logic (GPT-2)
        input_ids = tokenizer.encode(user_input, return_tensors='pt')
        
        with torch.no_grad():
            transformer_output = model(input_ids)
            logits = transformer_output.logits
            last_logit = logits[:, -1, :]
            rnn_input = last_logit.unsqueeze(0)
            rnn_output = rnn_model(rnn_input)

            response_token_id = torch.argmax(rnn_output, dim=-1).item()
            response = tokenizer.decode(response_token_id, skip_special_tokens=True)

    return jsonify({'response': response})

if __name__ == '__main__':
    app.run(debug=True)
