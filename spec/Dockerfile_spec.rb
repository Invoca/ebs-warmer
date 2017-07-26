require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')
    image.tag(repo: 'invocaops/ebs_warmer', tag: 'test')

    set :backend, :docker
    set :docker_image, image.id
    set :docker_container_create_options, { 'Entrypoint' => ['bash'] }
  end

  describe package('fio') do
    it { should be_installed }
  end

  describe file('/docker-entrypoint.sh') do
    it { should be_file }
  end
end
