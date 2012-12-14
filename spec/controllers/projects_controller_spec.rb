require 'spec_helper'

describe ProjectsController do
	def send_put(name) 
		put :update, id:1, project:{name:name}
	end

	describe "#update" do
		let(:project){ create :project }
		before do
			session[:userid] = create_admin.id
			Project.should_receive(:find).once.and_return project
		end

		context "update" do
			before{ send_put 'Prince' }

			describe Project do
				subject{ Project }
				its(:count){ should be 1 }
			end

			describe 'updated project' do
				subject{ Project.last }
				its(:name){ should eq 'Prince' }
			end

			describe "response" do
				subject{ response }
				it{ should redirect_to root_path }
			end

			describe "flash" do
				subject{ flash }
				its(:notice){ should eq 'Project updated' }
			end
		end

		context "error" do
			before{ send_put '' }
			
			describe 'response' do
				subject{ response }
			  it{ should render_template :edit }
			end
		end
	end
end
