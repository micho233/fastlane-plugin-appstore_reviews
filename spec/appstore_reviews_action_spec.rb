describe Fastlane::Actions::AppstoreReviewsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The appstore_reviews plugin is working!")

      Fastlane::Actions::AppstoreReviewsAction.run(nil)
    end
  end
end
