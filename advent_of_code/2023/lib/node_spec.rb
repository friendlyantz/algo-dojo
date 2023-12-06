require File.join(__dir__, 'node')
require 'pry'

RSpec.describe 'Node and Stacker' do
  describe 'Node' do
    it 'creates a node with correct data' do
      node = Node.new('lala')
      expect(node.data).to eq 'lala'
      expect(node.children).to eq []
    end
  end

  describe 'Stacker' do
    describe 'insretion' do
      it 'Stack can insert root node' do
        data = 'root'
        stacker = Stacker.new
        head = nil
        expect(stacker.insert(head, data).data).to eq 'root'
      end

      context 'with existing root' do
        let(:root) {  Node.new('root') }
        let(:stacker) { Stacker.new }
        let(:data_for_new_node_one) {  'data one' }
        let(:data_for_new_node_two) {  'data two' }
        let(:data_for_new_node_three) { 'data three' }

        it 'Stack can insert another 2 nodes on top of root node' do
          stacker.insert(root, data_for_new_node_one)
          expect(root.data).to eq 'root'
          expect(root.children.size).to eq 1
          expect(root.children.first.data).to eq 'data one'

          stacker.insert(root, data_for_new_node_two)
          expect(root.data).to eq 'root'
          expect(root.children.size).to eq 2
          expect(root.children.first.data).to eq 'data one'
        end

        context "with node sitting inside 'root'" do
          before do
            stacker.insert(root, data_for_new_node_one)
            stacker.insert(root, data_for_new_node_two)
          end

          it "Stack can insert another node on top of 'root/node_one' node" do
            node_one = root.children.first
            stacker.insert(node_one, data_for_new_node_three)

            expect(node_one.children.size).to eq 1
            expect(node_one.children.first.data).to eq 'data three'
          end
        end
      end
    end
  end
end
