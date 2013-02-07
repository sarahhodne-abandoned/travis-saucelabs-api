require 'spec_helper'

describe Travis::SaucelabsAPI do
  let(:endpoint) { 'http://user:password@travis-saucelabs.dev:1234' }
  let(:api) { Travis::SaucelabsAPI.new(endpoint) }

  describe '#capacity' do
    before do
      stub_get(endpoint, '/capacity').to_return(body: fixture('capacity.json'), headers: { content_type: 'text/html' })
    end

    it 'requests the correct resource' do
      api.capacity
      expect(a_get(endpoint, '/capacity')).to have_been_made
    end

    it 'returns the number of available VMs' do
      expect(api.capacity).to eq({ 'ichef' => 3 })
    end
  end

  describe '#start_instance' do
    context 'with no parameters' do
      before do
        stub_post(endpoint, '/instances').with(query: { image: Travis::SaucelabsAPI::DEFAULT_IMAGE }).to_return(body: fixture('start_instance.json'), headers: { content_type: 'text/html' })
      end

      it 'requests the correct resource' do
        api.start_instance
        expect(a_post(endpoint, '/instances').with(query: { image: Travis::SaucelabsAPI::DEFAULT_IMAGE })).to have_been_made
      end

      it 'returns the instance ID' do
        expect(api.start_instance).to eq({ 'instance_id' => '38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1' })
      end
    end

    context 'with a different image' do
      before do
        stub_post(endpoint, '/instances').with(query: { image: 'custom-image' }).to_return(body: fixture('start_instance.json'), headers: { content_type: 'text/html' })
      end

      it 'requests the correct resource' do
        api.start_instance(nil, 'custom-image')
        expect(a_post(endpoint, '/instances').with(query: { image: 'custom-image' })).to have_been_made
      end
    end

    context 'with startup info' do
      before do
        stub_post(endpoint, '/instances').with(query: { image: Travis::SaucelabsAPI::DEFAULT_IMAGE }, body: { foo: 'bar' }).to_return(body: fixture('start_instance.json'), headers: { content_type: 'text/html' })
      end

      it 'requests the correct resource' do
        api.start_instance({ foo: 'bar' }, Travis::SaucelabsAPI::DEFAULT_IMAGE)
        expect(a_post(endpoint, '/instances').with(query: { image: Travis::SaucelabsAPI::DEFAULT_IMAGE }, body: { foo: 'bar' })).to have_been_made
      end
    end
  end

  describe '#list_instances' do
    before do
      stub_get(endpoint, '/instances').to_return(body: fixture('instances.json'), content_type: 'text/html')
    end

    it 'requests the correct resource' do
      api.list_instances
      expect(a_get(endpoint, '/instances')).to have_been_made
    end

    it 'returns the running instances' do
      expect(api.list_instances).to eq({ 'instances' => ['38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1'] })
    end
  end

  describe '#instance_info' do
    before do
      stub_get(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252').to_return(body: fixture('instance_info.json'), content_type: 'text/html')
    end

    it 'requests the correct resource' do
      api.instance_info('38257917-4fac-68fc-11f4-1575d2ec6847@travis1#itako13252')
      expect(a_get(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252')).to have_been_made
    end

    it 'returns information about the instance' do
      expect(api.instance_info('38257917-4fac-68fc-11f4-1575d2ec6847@travis1#itako13252')).to eq({
        'public_ip' => '10.10.10.10',
        'vnc_port' => '5900',
        'FQDN' => 'vm1.example.com',
        'time_created' => 1355294100.609689,
        'instance_id' => '38257917-4fac-68fc-11f4-1575d2ec6847@api#vm1',
        'image_id' => 'ichef-osx8-10.8-working',
        'State' => 'Running',
        'private_ip' => '10.10.20.10',
        'real_image_id' => 'ichef-osx8-10.8-working',
      })
    end
  end

  describe '#kill_instance' do
    before do
      stub_delete(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252').to_return(body: fixture('kill_instance.json'), content_type: 'text/html')
    end

    it 'requests the correct resource' do
      api.kill_instance('38257917-4fac-68fc-11f4-1575d2ec6847@travis1#itako13252')
      expect(a_delete(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252')).to have_been_made
    end
  end

  describe '#allow_outgoing' do
    before do
      stub_post(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252/allow_outgoing').to_return(body: fixture('allow_outgoing.json'), content_type: 'text/html')
    end

    it 'requests the correct resource' do
      api.allow_outgoing('38257917-4fac-68fc-11f4-1575d2ec6847@travis1#itako13252')
      expect(a_post(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252/allow_outgoing')).to have_been_made
    end
  end

  describe '#save_image' do
    before do
      stub_post(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252/save_image').to_return(body: fixture('save_image.json'), content_type: 'text/html')
    end

    it 'requests the correct resource' do
      api.save_image('38257917-4fac-68fc-11f4-1575d2ec6847@travis1#itako13252')
      expect(a_post(endpoint, '/instances/38257917-4fac-68fc-11f4-1575d2ec6847@travis1%23itako13252/save_image')).to have_been_made
    end
  end


end
