# frozen_string_literal: true

RSpec.shared_examples '200' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:ok)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq(response_body.to_json)
  end
end

RSpec.shared_examples '201' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:created)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq(response_body.to_json)
  end
end

RSpec.shared_examples '202' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:accepted)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq(response_body.to_json)
  end
end

RSpec.shared_examples '204' do
  it 'responds with success status' do
    subject
    expect(response).to have_http_status(:no_content)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq('')
  end
end

RSpec.shared_examples '400' do
  it 'responds with 400' do
    subject
    expect(response).to have_http_status(:bad_request)
  end

  it 'responds with proper error code' do
    subject
    expect(response_body['errors'][0]['code']).to eq(error_code)
  end
end

RSpec.shared_examples '401' do
  it 'responds with 401' do
    subject
    expect(response).to have_http_status(:unauthorized)
  end

  it 'responds with proper body' do
    response_body = {
      errors: [
        {
          title: 'Not authenticated',
          detail: nil,
          code: 'not_authenticated',
          status: 401
        }
      ]
    }.to_json
    subject
    expect(response.body).to eq(response_body)
  end
end

RSpec.shared_examples '403' do
  it 'returns 403 status' do
    subject
    expect(response).to have_http_status(403)
  end

  it 'responds with proper status and with title' do
    subject
    body = JSON.parse(response.body)
    expect(body['errors'][0]['status']).to eq(403)
    expect(body['errors'][0].key?('title')).to eq true
  end
end

RSpec.shared_examples '404' do
  it 'returns 404 status' do
    subject
    expect(response).to have_http_status(404)
  end

  it 'responds with proper body' do
    response_body = {
      errors: [
        {
          title: 'Record not found',
          detail: nil,
          code: 'record_not_found',
          status: 404
        }
      ]
    }.to_json
    subject
    expect(response.body).to eq(response_body)
  end
end

RSpec.shared_examples '409' do
  it 'returns 409 status' do
    subject
    expect(response).to have_http_status(409)
  end

  it 'responds with proper body' do
    response_body = {
      errors: [
        {
          title: 'URL/params ID conflict',
          detail: 'ID in URL is different from ID in params',
          code: 'url_params_id_conflict',
          status: 409
        }
      ]
    }.to_json
    subject
    expect(response.body).to eq(response_body)
  end
end

RSpec.shared_examples '415' do
  it 'returns 415 status' do
    subject
    expect(response).to have_http_status(415)
  end

  it 'responds with proper body' do
    response_body = {
      errors: [
        {
          title: 'Unsupported Media Type',
          detail: nil,
          code: 'unsupported_media_type',
          status: 415
        }
      ]
    }.to_json
    subject
    expect(response.body).to eq(response_body)
  end
end

RSpec.shared_examples '422' do
  it 'responds with 422' do
    subject
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'calls RequestServices::SerializeErrors' do
    expect(RequestServices::SerializeErrors).to receive(:call).once.and_return(Result::Success.new)
    subject
  end
end

RSpec.shared_examples '500' do
  it 'responds with 500' do
    subject
    expect(response).to have_http_status(:internal_server_error)
  end

  it 'responds with proper body' do
    subject
    expect(response.body).to eq(response_body.to_json)
  end
end
