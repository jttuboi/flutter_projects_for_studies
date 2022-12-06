package com.vonage.tutorial.opentok.opentok_flutter_samples.one_to_one_video

import android.opengl.GLSurfaceView
import android.util.Log
import com.opentok.android.*
import com.vonage.tutorial.opentok.opentok_flutter_samples.MainActivity
import com.vonage.tutorial.opentok.opentok_flutter_samples.config.SdkState

class OneToOneVideo(mainActivity: MainActivity) {

    private var session: Session? = null
    private var publisher: Publisher? = null
    private var subscriber: Subscriber? = null

    private var activity: MainActivity? = null

    private lateinit var opentokVideoPlatformView: OpentokVideoPlatformView

    private val sessionListener: Session.SessionListener = object : Session.SessionListener {
        override fun onConnected(session: Session) {
            Log.d("", "OneToOneVideo.session.onConnected(${session.sessionId})")
      
            publisher = Publisher.Builder(activity).build().apply {
                setPublisherListener(publisherListener)
                renderer?.setStyle(
                    BaseVideoRenderer.STYLE_VIDEO_SCALE,
                    BaseVideoRenderer.STYLE_VIDEO_FILL
                )

                opentokVideoPlatformView.publisherContainer.addView(view)
                if (view is GLSurfaceView) {
                    (view as GLSurfaceView).setZOrderOnTop(true)
                }
            }

            activity?.updateFlutterState(SdkState.loggedIn, activity!!.oneToOneVideoMethodChannel)
            session.publish(publisher)
        }

        override fun onDisconnected(session: Session) {
            Log.d("", "OneToOneVideo.session.onDisconnected(${session.sessionId})")

            activity?.updateFlutterState(SdkState.loggedOut, activity!!.oneToOneVideoMethodChannel)
        }

        override fun onStreamReceived(session: Session, stream: Stream) {
            Log.d("", "OneToOneVideo.session.onStreamReceived(${session.sessionId}, ${stream.streamId})")

            if (subscriber == null) {
                subscriber = Subscriber.Builder(activity, stream).build().apply {
                    renderer?.setStyle(
                        BaseVideoRenderer.STYLE_VIDEO_SCALE,
                        BaseVideoRenderer.STYLE_VIDEO_FILL
                    )
                    setSubscriberListener(subscriberListener)
                    session.subscribe(this)

                    opentokVideoPlatformView.subscriberContainer.addView(view)
                }
            }
        }

        override fun onStreamDropped(session: Session, stream: Stream) {
            Log.d("", "OneToOneVideo.session.onStreamDropped(${session.sessionId}, ${stream.streamId})")

            if (subscriber != null) {
                subscriber = null

                opentokVideoPlatformView.subscriberContainer.removeAllViews()
            }
        }

        override fun onError(session: Session, opentokError: OpentokError) {
            Log.d("", "OneToOneVideo.session.onError(${session.sessionId}, ${opentokError.message})")

            activity?.updateFlutterState(SdkState.error, activity!!.oneToOneVideoMethodChannel)
        }
    }

    private val publisherListener: PublisherKit.PublisherListener = object :
        PublisherKit.PublisherListener {
        override fun onStreamCreated(publisherKit: PublisherKit, stream: Stream) {
            Log.d("", "OneToOneVideo.publisher.onStreamCreated(${publisherKit.stream.streamId}, ${stream.streamId})")
        }

        override fun onStreamDestroyed(publisherKit: PublisherKit, stream: Stream) {
            Log.d("", "OneToOneVideo.publisher.onStreamDestroyed(${publisherKit.stream.streamId}, ${stream.streamId})")
        }

        override fun onError(publisherKit: PublisherKit, opentokError: OpentokError) {
            Log.d("", "OneToOneVideo.publisher.onStreamDestroyed(${publisherKit.stream.streamId}, ${opentokError.message})")
            
            activity?.updateFlutterState(SdkState.error, activity!!.oneToOneVideoMethodChannel)
        }
    }

    var subscriberListener: SubscriberKit.SubscriberListener = object :
        SubscriberKit.SubscriberListener {
        override fun onConnected(subscriberKit: SubscriberKit) {
            Log.d("", "OneToOneVideo.subscriber.onConnected(${subscriberKit.stream.streamId})")
        }

        override fun onDisconnected(subscriberKit: SubscriberKit) {
            Log.d("", "OneToOneVideo.subscriber.onDisconnected(${subscriberKit.stream.streamId})")

            activity?.updateFlutterState(SdkState.loggedOut, activity!!.oneToOneVideoMethodChannel)
        }

        override fun onError(subscriberKit: SubscriberKit, opentokError: OpentokError) {
            Log.d("", "OneToOneVideo.subscriber.onDisconnected(${subscriberKit.stream.streamId}, ${opentokError.message})")
            
            activity?.updateFlutterState(SdkState.error, activity!!.oneToOneVideoMethodChannel)
        }
    }

    init {
        activity = mainActivity
        opentokVideoPlatformView = OpentokVideoFactory.getViewInstance(activity)
    }

    fun initSession(apiKey: String, sessionId: String, token: String) {
        session = Session.Builder(activity, apiKey, sessionId).build()
        session?.setSessionListener(sessionListener)
        session?.connect(token)
    }

    fun swapCamera() {
        publisher?.cycleCamera()
    }

    fun toggleAudio(publishAudio: Boolean) {
        publisher?.publishAudio = publishAudio
    }

    fun toggleVideo(publishVideo: Boolean) {
        publisher?.publishVideo = publishVideo
    }
}